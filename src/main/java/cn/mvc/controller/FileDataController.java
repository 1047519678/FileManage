package cn.mvc.controller;

import cn.mvc.pojo.Delivery;
import cn.mvc.pojo.FileData;
import cn.mvc.pojo.FileType;
import cn.mvc.pojo.FileTypeUser;
import cn.mvc.service.FileDataService;
import cn.mvc.service.FileTypeService;
import cn.mvc.service.UserService;
import cn.mvc.tools.GetAutoCode;
import cn.mvc.tools.GetPageList;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value = "/file")
public class FileDataController {
    @Autowired
    public FileDataService fileDataService;
    @Autowired
    public UserService userService;
    @Autowired
    public FileTypeService fileTypeService;

    @RequestMapping("/jumpFileInfo")
    public String jumpFileInfo(Model model,HttpServletRequest request) {
        //查询报表未选类别是默认带出IQC人员所负责的类别的所有厂商
        //类别只能选所负责的
        String userId = request.getParameter("userId");
        List<Map<String,Object>> vendorList = fileDataService.GetAccountList2(userId);
        List<FileType> typeList = fileTypeService.getQcTypeNoList(userId);
        model.addAttribute("vendorList",vendorList);
        model.addAttribute("typeList",typeList);
        model.addAttribute("status",request.getParameter("status"));
        return "file/fileInfo";
    }

    @RequestMapping("/jumpUserFileInfo")
    public String jumpUserFileInfo(Model model,HttpServletRequest request) {
        //model.addAttribute("status",request.getParameter("status"));
        String account = request.getParameter("account");
        List<Delivery> partList = fileTypeService.getPartNoList(account);
        model.addAttribute("partList",partList);
        model.addAttribute("account",account);
        return "file/userFileInfo";
    }

    @RequestMapping("/jumpUpload")
    public String jumpUpload(Model model,HttpServletRequest request) {
        String userId = request.getParameter("userId");
        List<FileType> typeList = fileTypeService.getTypeNoList();
        List<Delivery> partList = fileTypeService.getPartNoList(userId);
        FileTypeUser fileTypeUser = fileTypeService.getTypeNoByUser(userId);
        String typeNo = "";
        if (fileTypeUser == null){
            typeNo = "";
        }else{
            typeNo = fileTypeUser.getTypeNo();
        }
        model.addAttribute("typeList",typeList);
        model.addAttribute("partList",partList);
        model.addAttribute("typeNo",typeNo);
        return "file/uploadFile";
    }

    /******** layui重写start ********/

    @RequestMapping(value = "/showUserTable/{account}")
    @ResponseBody
    public JSONObject showUserTableJson(@PathVariable("account") String account,Model model,String page, String limit) {
        List<Delivery> partList = fileTypeService.getPartNoList(account);
        List<FileData> dataList = fileDataService.showFileByUser(account);
        model.addAttribute("partList",partList);
        return GetPageList.pageInfo(dataList,page,limit);
    }

    @RequestMapping(value = "/showTable/{userId}/{status}/{factory}")
    @ResponseBody
    public JSONObject showTableJson(@PathVariable("userId") String userId,@PathVariable("status") String status,@PathVariable("factory") String factory, String page, String limit) {
        List<FileData> dataList = fileDataService.showFileByStatus(userId,status,factory);
        return GetPageList.pageInfo(dataList,page,limit);
    }

    @RequestMapping(value = "/getVendorList", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String getVendorList(HttpServletRequest request) {
        String species = request.getParameter("species");
        String userId = request.getParameter("userId");
        List<Map<String,Object>> vendorList;
        if ("".equals(species) || species == null){
            vendorList = fileDataService.GetAccountList2(userId);
        }else{
            vendorList = fileDataService.GetAccountList(species);
        }
        return JSON.toJSONString(vendorList);
    }

    @RequestMapping(value = "/getPartNoList", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String getPartNoList(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        List<Delivery> partList = fileTypeService.getPartNoList(userId);
        return JSON.toJSONString(partList);
    }

    @RequestMapping(value = "/selTable")
    @ResponseBody
    public JSONObject selTable(String page, String limit, HttpServletRequest request) {
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String vendor = request.getParameter("vendor");
        String species = request.getParameter("species");
        String partNo = request.getParameter("partNo");
        String status = request.getParameter("status");
        String userId = request.getParameter("userId");
        String factory = request.getParameter("factory");
        List<FileData> dataList = fileDataService.GetDataBySel(startTime,endTime,vendor,species,partNo,status,userId,factory);
        return GetPageList.pageInfo(dataList,page,limit);
    }

    @RequestMapping(value = "/selUserTable")
    @ResponseBody
    public JSONObject selUserTable(String page, String limit, HttpServletRequest request) {
        String factory = request.getParameter("factory");
        String partNo = request.getParameter("partNo");
        String shipTime = request.getParameter("shipTime");
        String account = request.getParameter("account");
        List<FileData> dataList = fileDataService.GetDataByUserSel(factory,partNo,shipTime,account);
        return GetPageList.pageInfo(dataList,page,limit);
    }

    @RequestMapping(value = "/alterStatus")
    @ResponseBody
    public String alterStatus(FileData fileData) {
        if (fileDataService.alterFileStatus(fileData)) {
            return "success";
        } else {
            return "error";
        }
    }

    @RequestMapping(value = "/upload", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public JSONObject upload(FileData fileData,MultipartFile file, HttpServletResponse response) {
        //String path = request.getSession().getServletContext().getRealPath("/upload");
        JSONObject json = new JSONObject();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
        String uploadTime = df.format(new Date());
        String account = fileData.getAccount();
        String partNo = fileData.getPartNo();
        String factory = fileData.getFactory();
        String species = fileData.getSpecies();
        String code = sdf.format(new Date()) + fileData.getTimes();
        String path = ("C:\\uploadTemp\\" + factory + "\\" + account + "\\" + partNo + "\\" + uploadTime + "\\");
        String fileName = partNo + code + ".pdf";
        //校验是否是否重复上传，重复为真。
        if (account == null || partNo == null || factory == null || species == null){
            json.put("code",4);
            json.put("msg","數據不完整，請確認后重新提交！");
            return json;
        }else if (fileDataService.checkDataUpload(species,factory,fileName)){
            json.put("code",3);
            json.put("msg","文件重複上傳，請確認上傳次數選擇是否正確！");
            return json;
        }else{
            try {
                File dir = new File(path, fileName);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                file.transferTo(dir);
            } catch (IOException e) {
                e.printStackTrace();
            }
            fileData.setFileName(fileName);
            fileData.setStatus(0);
            if (fileDataService.saveFile(fileData)){
                if (fileTypeService.getTypeNoByUser(account) == null){
                    fileTypeService.setTypeNoByUser(fileData.getSpecies(),account);
                }else{
                    fileTypeService.alterTypeNo(fileData.getSpecies(),account);
                }
                //return "file/uploadFile";
                json.put("code",0);
                json.put("msg","上传成功！");
                return json;
            }else{
                json.put("code",1);
                json.put("msg","上传失败，请重试！");
                return json;
            }
        }
    }

    @RequestMapping("/preview")
    public void preview(String account, String partNo, String fileName, String factory, String uploadTime, HttpServletResponse response) throws IOException {
        String filePath = "C:\\uploadTemp\\" + factory + "\\" + account + "\\" + partNo + "\\" + uploadTime.substring(0,10) + "\\" + fileName;
        System.out.println("filePath:" + filePath);
        File file = new File(filePath);
        if (!file.exists()) {
            response.sendError(404, "File not found!");
            return;
        }
        BufferedInputStream br = new BufferedInputStream(new FileInputStream(file));
        byte[] bs = new byte[1024];
        int len = 0;
        response.reset();
        URL u = new URL("file:///" + filePath);
        response.setContentType(u.openConnection().getContentType());
        response.setHeader("Content-Disposition", "inline;filename="
                + file.getName());
        OutputStream out = response.getOutputStream();
        while ((len = br.read(bs)) > 0) {
            out.write(bs, 0, len);
        }
        out.flush();
        out.close();
        br.close();
    }

    /******** layui重写end ********/

}
