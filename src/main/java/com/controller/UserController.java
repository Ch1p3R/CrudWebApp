package com.controller;

import com.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import com.service.UserService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;


@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping(value = "users", method = RequestMethod.GET)
    public String userList(@RequestParam(value = "page", required = false) Integer page, Map<String, Object> map) {
        PagedListHolder<User> pagedListHolder = new PagedListHolder(userService.getAllUsers());
        pagedListHolder.setPageSize(5);
        map.put("maxPages", pagedListHolder.getPageCount());
        if(page == null || page < 1 || page > pagedListHolder.getPageCount()) {
            page = 1;
        }
        map.put("page", page);
        if(page < 1 || page > pagedListHolder.getPageCount()){
            pagedListHolder.setPage(0);
            map.put("usersList", pagedListHolder.getPageList());
        }
        else if(page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page-1);
            map.put("usersList", pagedListHolder.getPageList());
        }
        map.put("user", new User());
        return "users";
    }

    @RequestMapping(value = "/users/edit/{id}", method = RequestMethod.GET)
    public String editUser(@ModelAttribute("user") User user, @PathVariable("id") int userId,
                           @RequestParam(value = "page", required = false) Integer page, Map<String, Object> map){
        if (page == null)page = 1;
        PagedListHolder<User> pagedListHolder = new PagedListHolder(userService.getAllUsers());
        pagedListHolder.setPageSize(5);
        pagedListHolder.setPage(page-1);
        map.put("user", userService.getUser(userId));
        map.put("usersList", pagedListHolder.getPageList());
        map.put("page", page);
        return "users";
    }

    @RequestMapping(value = "/users/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user, @RequestParam(value = "page", required = false) Integer page,
                          BindingResult result, RedirectAttributes redirectAttributes){
        if (!result.hasErrors()) {
            if (user.getId() == 0) {
                userService.add(user);
                PagedListHolder<User> pagedListHolder = new PagedListHolder(userService.getAllUsers());
                pagedListHolder.setPageSize(5);
                redirectAttributes.addAttribute("page", pagedListHolder.getPageCount());
            } else {
                User editUser = userService.getUser(user.getId());
                user.setTimeStamp(editUser.getTimeStamp());
                userService.edit(user);
                redirectAttributes.addAttribute("page", page);
            }
        }
        return "redirect:/users";
    }

    @RequestMapping(value = "/users/remove/{id}")
    public String deleteUser(@PathVariable("id") int userId, @RequestParam(value = "page", required = false) Integer page,
                             RedirectAttributes redirectAttributes) {
        redirectAttributes.addAttribute("page", page);
        userService.delete(userId);
        return "redirect:/users";
    }

    @RequestMapping(value = "/users/search/")
    public String searchUser(@RequestParam(value = "searchName", required = false) String searchName, Map<String, Object> map){
        List <User> userList = userService.getAllUsers(searchName);
        map.put("usersList", userList);
        return "user_search";
    }

}
