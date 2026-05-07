package br.edu.escolaconectada.service;
import br.edu.escolaconectada.model.Aluno;
import br.edu.escolaconectada.repository.AlunoRepository;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class AlunoService {
    private final AlunoRepository alunoRepository;
    public AlunoService(AlunoRepository alunoRepository) { this.alunoRepository = alunoRepository; }
    public Aluno salvar(Aluno obj) { return alunoRepository.save(obj); }
    public List<Aluno> listar() { return alunoRepository.findAll(); }
    public Aluno buscarPorId(Long id) { return alunoRepository.findById(id).orElse(null); }
}
