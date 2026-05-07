package br.edu.escolaconectada.controller;
import br.edu.escolaconectada.model.Comunicado;
import br.edu.escolaconectada.repository.ComunicadoRepository;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController @RequestMapping("/comunicados") @CrossOrigin("*")
public class ComunicadoController {
 private final ComunicadoRepository repository;
 public ComunicadoController(ComunicadoRepository repository) { this.repository = repository; }
 @PostMapping public Comunicado cadastrar(@RequestBody Comunicado comunicado) { return repository.save(comunicado); }
 @GetMapping public List<Comunicado> listar() { return repository.findAll(); }
 @GetMapping("/aluno/{idAluno}") public List<Comunicado> listarPorAluno(@PathVariable Long idAluno) { return repository.findByAlunoId(idAluno); }
}
