package br.edu.escolaconectada.model;
import jakarta.persistence.*;
@Entity
public class Professor {
 @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
 private String nome; private String email; private String disciplina;
 public Long getId(){return id;} public void setId(Long id){this.id=id;}
 public String getNome(){return nome;} public void setNome(String nome){this.nome=nome;}
 public String getEmail(){return email;} public void setEmail(String email){this.email=email;}
 public String getDisciplina(){return disciplina;} public void setDisciplina(String disciplina){this.disciplina=disciplina;}
}
