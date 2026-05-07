package br.edu.escolaconectada.controller;
import br.edu.escolaconectada.model.Professor;
import br.edu.escolaconectada.service.ProfessorService;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController @RequestMapping("/professores") @CrossOrigin("*")
public class ProfessorController {
 private final ProfessorService professorService;
 public ProfessorController(ProfessorService professorService) { this.professorService=professorService; }
 @PostMapping public Professor cadastrar(@RequestBody Professor professor) { return professorService.salvar(professor); }
 @GetMapping public List<Professor> listar() { return professorService.listar(); }
 @GetMapping("/{id}") public Professor buscarPorId(@PathVariable Long id) { return professorService.buscarPorId(id); }
}
