package br.edu.escolaconectada.service;
import br.edu.escolaconectada.model.Responsavel;
import br.edu.escolaconectada.repository.ResponsavelRepository;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class ResponsavelService {
    private final ResponsavelRepository responsavelRepository;
    public ResponsavelService(ResponsavelRepository responsavelRepository) { this.responsavelRepository = responsavelRepository; }
    public Responsavel salvar(Responsavel obj) { return responsavelRepository.save(obj); }
    public List<Responsavel> listar() { return responsavelRepository.findAll(); }
    public Responsavel buscarPorId(Long id) { return responsavelRepository.findById(id).orElse(null); }
}
