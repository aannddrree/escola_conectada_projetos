package br.edu.escolaconectada.service;
import br.edu.escolaconectada.model.Resposta;
import br.edu.escolaconectada.repository.RespostaRepository;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class RespostaService {
    private final RespostaRepository respostaRepository;
    public RespostaService(RespostaRepository respostaRepository) { this.respostaRepository = respostaRepository; }
    public Resposta salvar(Resposta obj) { return respostaRepository.save(obj); }
    public List<Resposta> listar() { return respostaRepository.findAll(); }
    public Resposta buscarPorId(Long id) { return respostaRepository.findById(id).orElse(null); }
}
