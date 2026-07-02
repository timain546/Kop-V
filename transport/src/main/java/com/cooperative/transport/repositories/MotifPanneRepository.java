package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.MotifPanne;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MotifPanneRepository extends JpaRepository<MotifPanne, Long> {
}
