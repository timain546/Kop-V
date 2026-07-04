package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.IndisponibiliteVehicule;
import com.cooperative.transport.entities.Vehicule;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface IndisponibiliteVehiculeRepository extends JpaRepository<IndisponibiliteVehicule, Long> {

    List<IndisponibiliteVehicule> findByVehiculeOrderByDateDebutDesc(Vehicule vehicule);

    Optional<IndisponibiliteVehicule> findFirstByVehiculeAndMotifOrderByDateDebutDesc(
            Vehicule vehicule, IndisponibiliteVehicule.MotifIndisponibilite motif);

    Optional<IndisponibiliteVehicule> findFirstByVehiculeOrderByDateDebutDesc(Vehicule vehicule);
}