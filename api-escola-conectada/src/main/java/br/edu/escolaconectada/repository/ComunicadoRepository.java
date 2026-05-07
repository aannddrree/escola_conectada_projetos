package br.edu.escolaconectada.repository;
import br.edu.escolaconectada.model.Comunicado;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface ComunicadoRepository extends JpaRepository<Comunicado, Long> {
    List<Comunicado> findByAlunoId(Long alunoId);
}
