package ro.alex.auth.service;

import ro.alex.auth.model.User;

public interface UserService {
    void save(User user);

    User findByUsername(String username);
}
