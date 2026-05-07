package br.edu.escolaconectada.repository;
import br.edu.escolaconectada.model.Aluno;
import org.springframework.data.jpa.repository.JpaRepository;
public interface AlunoRepository extends JpaRepository<Aluno, Long> {}
