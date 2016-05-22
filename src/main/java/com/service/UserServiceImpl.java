package com.service;

import com.dao.UserDao;
import com.dao.UserDaoImpl;
import com.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    public void setUserDaoImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    @Transactional
    public void add(User user) {
        userDao.add(user);
    }
    @Transactional
    public void edit(User user) {
        userDao.edit(user);
    }
    @Transactional
    public void delete(int userId) {
        userDao.delete(userId);
    }
    @Transactional
    public User getUser(int userId) {
        return userDao.getUser(userId);
    }
    @Transactional
    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }
    @Transactional
    public List<User> getAllUsers(String userName) {
        return userDao.getAllUsers(userName);
    }
}
