package br.edu.escolaconectada.controller;
import br.edu.escolaconectada.model.Aluno;
import br.edu.escolaconectada.service.AlunoService;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController @RequestMapping("/alunos") @CrossOrigin("*")
public class AlunoController {
 private final AlunoService alunoService;
 public AlunoController(AlunoService alunoService) { this.alunoService=alunoService; }
 @PostMapping public Aluno cadastrar(@RequestBody Aluno aluno) { return alunoService.salvar(aluno); }
 @GetMapping public List<Aluno> listar() { return alunoService.listar(); }
 @GetMapping("/{id}") public Aluno buscarPorId(@PathVariable Long id) { return alunoService.buscarPorId(id); }
}
