package br.edu.escolaconectada.repository;
import br.edu.escolaconectada.model.Professor;
import org.springframework.data.jpa.repository.JpaRepository;
public interface ProfessorRepository extends JpaRepository<Professor, Long> {}
