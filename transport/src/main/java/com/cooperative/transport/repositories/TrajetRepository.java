package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Trajet;
import org.springframework.data.jpa.repository.JpaRepository;

// ⚠️ TEMPORAIRE — sera remplacé quand mon binôme aura fini son vrai Trajet
public interface TrajetRepository extends JpaRepository<Trajet, Long> {
}