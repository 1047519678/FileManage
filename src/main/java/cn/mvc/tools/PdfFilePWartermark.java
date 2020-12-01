package cn.mvc.tools;

import com.itextpdf.text.Element;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.*;

import javax.swing.*;
import java.awt.*;
import java.io.FileOutputStream;

public class PdfFilePWartermark {
    public static void main(String[] args) {
        waterMark(15, 45, "D://Downloads//各廠區停車識別證.pdf", "D://Downloads//各廠區停車識別證1.pdf", "PHIHONG");
    }

    private static int interval = -5;

    public static void waterMark(float fontSize, float rotation, String inputFile, String outputFile, String waterMarkName) {
        try {
            PdfReader reader = new PdfReader(inputFile);
            PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(outputFile));
            BaseFont base = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.EMBEDDED);
            Rectangle pageRect = null;
            PdfGState gs = new PdfGState();
            gs.setFillOpacity(0.3f);
            gs.setStrokeOpacity(0.4f);
            int total = reader.getNumberOfPages() + 1;
            JLabel label = new JLabel();
            FontMetrics metrics;
            int textH = 0;
            int textW = 0;
            label.setText(waterMarkName);
            metrics = label.getFontMetrics(label.getFont());
            textH = metrics.getHeight();
            textW = metrics.stringWidth(label.getText());
            PdfContentByte under;
            for (int i = 1; i < total; i++) {
                pageRect = reader.getPageSizeWithRotation(i);
                under = stamper.getOverContent(i);
                under.saveState();
                under.setGState(gs);
                under.beginText();
                under.setFontAndSize(base, fontSize);
                // 水印文字成45度角倾斜
                for (int height = interval + textH; height < pageRect.getHeight(); height = height + textH * 3) {
                    for (int width = interval + textW; width < pageRect.getWidth() + textW; width = width + textW * 2) {
                        under.showTextAligned(Element.ALIGN_LEFT, waterMarkName, width - textW, height - textH, rotation);
                    }
                }
                // 添加水印文字
                under.endText();
            }
            stamper.close();
            reader.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
