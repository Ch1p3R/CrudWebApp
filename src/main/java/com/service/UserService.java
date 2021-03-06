package com.service;

import com.model.User;
import java.util.List;


public interface UserService {
    public void add(User user);
    public void edit(User user);
    public void delete(int userId);
    public User getUser(int userId);
    public List<User> getAllUsers();
    public List<User> getAllUsers(String s);
}
