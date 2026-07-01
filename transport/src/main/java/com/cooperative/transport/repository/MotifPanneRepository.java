package com.cooperative.transport.repository;

import com.cooperative.transport.entity.MotifPanne;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MotifPanneRepository extends JpaRepository<MotifPanne, Long> {
}
