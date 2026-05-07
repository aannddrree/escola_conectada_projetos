package br.edu.escolaconectada.service;
import br.edu.escolaconectada.model.Professor;
import br.edu.escolaconectada.repository.ProfessorRepository;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class ProfessorService {
    private final ProfessorRepository professorRepository;
    public ProfessorService(ProfessorRepository professorRepository) { this.professorRepository = professorRepository; }
    public Professor salvar(Professor obj) { return professorRepository.save(obj); }
    public List<Professor> listar() { return professorRepository.findAll(); }
    public Professor buscarPorId(Long id) { return professorRepository.findById(id).orElse(null); }
}
