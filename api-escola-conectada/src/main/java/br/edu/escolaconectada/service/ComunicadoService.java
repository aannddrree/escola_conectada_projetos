package br.edu.escolaconectada.service;
import br.edu.escolaconectada.model.Comunicado;
import br.edu.escolaconectada.repository.ComunicadoRepository;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class ComunicadoService {
    private final ComunicadoRepository comunicadoRepository;
    public ComunicadoService(ComunicadoRepository comunicadoRepository) { this.comunicadoRepository = comunicadoRepository; }
    public Comunicado salvar(Comunicado obj) { return comunicadoRepository.save(obj); }
    public List<Comunicado> listar() { return comunicadoRepository.findAll(); }
    public Comunicado buscarPorId(Long id) { return comunicadoRepository.findById(id).orElse(null); }
}
