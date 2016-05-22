package com.dao;

import com.model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class UserDaoImpl implements UserDao {
    @Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }
    public void add(User user) {
        getCurrentSession().save(user);
    }

    public void edit(User user) {
        getCurrentSession().update(user);
    }

    public void delete(int userId) {
        User user = (User) getCurrentSession().load(User.class, userId);
        if (user != null)
        getCurrentSession().delete(getUser(userId));
    }

    public User getUser(int userId) {
        return (User) getCurrentSession().get(User.class, userId);
    }
    @SuppressWarnings("unchecked")
    public List<User> getAllUsers() {
        return getCurrentSession().createQuery("from User").list();
    }
    public List<User> getAllUsers(String userName){
        List<User> userList = getCurrentSession().createQuery("SELECT u FROM User u WHERE u.name like '"+ userName +"'").list();
        if (userList.isEmpty()){
            userList = getCurrentSession().createQuery("select u from User u where u.id like '"+userName+"'" ).list();
        }
        return userList;
    }


}
