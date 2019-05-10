package ro.alex.auth.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import ro.alex.auth.model.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
