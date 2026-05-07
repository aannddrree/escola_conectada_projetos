package br.edu.escolaconectada.controller;
import br.edu.escolaconectada.model.Responsavel;
import br.edu.escolaconectada.service.ResponsavelService;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController @RequestMapping("/responsaveis") @CrossOrigin("*")
public class ResponsavelController {
 private final ResponsavelService responsavelService;
 public ResponsavelController(ResponsavelService responsavelService) { this.responsavelService=responsavelService; }
 @PostMapping public Responsavel cadastrar(@RequestBody Responsavel responsavel) { return responsavelService.salvar(responsavel); }
 @GetMapping public List<Responsavel> listar() { return responsavelService.listar(); }
 @GetMapping("/{id}") public Responsavel buscarPorId(@PathVariable Long id) { return responsavelService.buscarPorId(id); }
}
