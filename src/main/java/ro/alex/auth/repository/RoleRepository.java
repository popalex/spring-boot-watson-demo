package ro.alex.auth.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import ro.alex.auth.model.Role;

public interface RoleRepository extends JpaRepository<Role, Long>{
}
