package br.edu.escolaconectada.controller;
import br.edu.escolaconectada.model.Resposta;
import br.edu.escolaconectada.repository.RespostaRepository;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController @RequestMapping("/respostas") @CrossOrigin("*")
public class RespostaController {
 private final RespostaRepository repository;
 public RespostaController(RespostaRepository repository) { this.repository = repository; }
 @PostMapping public Resposta cadastrar(@RequestBody Resposta resposta) { return repository.save(resposta); }
 @GetMapping public List<Resposta> listar() { return repository.findAll(); }
 @GetMapping("/comunicado/{idComunicado}") public List<Resposta> listarPorComunicado(@PathVariable Long idComunicado) { return repository.findByComunicadoId(idComunicado); }
}
