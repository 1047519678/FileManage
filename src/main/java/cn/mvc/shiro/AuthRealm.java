package cn.mvc.shiro;

import cn.mvc.pojo.User;
import cn.mvc.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class AuthRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        System.out.println("授权方法");
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        User user = (User) principalCollection.getPrimaryPrincipal();    //获得当前登陆的用户
                 /*Set<Role> roles = user.getRoles();     //当前用户拥有的角色，根据自己的entity
                //指示当前用户能访问的资源
                 for(Role role : roles) {
                         info.addStringPermission(role.getName());
                     }*/
        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        System.out.println("认证方法" + authenticationToken.getPrincipal());
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        String userName= token.getPrincipal().toString();
        String password= new String( token.getPassword());
        //获取数据库中的密码
        User user = userService.checkLogin(userName,password);
        if (user == null){
            throw new AuthenticationException();
        }
        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(userName,password,getName());
        return info;
    }
}
