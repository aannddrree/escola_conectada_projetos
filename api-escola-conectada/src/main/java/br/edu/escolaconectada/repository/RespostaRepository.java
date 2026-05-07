package br.edu.escolaconectada.repository;
import br.edu.escolaconectada.model.Resposta;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface RespostaRepository extends JpaRepository<Resposta, Long> {
    List<Resposta> findByComunicadoId(Long comunicadoId);
}
