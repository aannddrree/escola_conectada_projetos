package br.edu.escolaconectada.model;
import jakarta.persistence.*;
@Entity
public class Aluno {
 @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
 private String nome; private Integer idade; private String serie;
 @ManyToOne private Responsavel responsavel;
 public Long getId(){return id;} public void setId(Long id){this.id=id;}
 public String getNome(){return nome;} public void setNome(String nome){this.nome=nome;}
 public Integer getIdade(){return idade;} public void setIdade(Integer idade){this.idade=idade;}
 public String getSerie(){return serie;} public void setSerie(String serie){this.serie=serie;}
 public Responsavel getResponsavel(){return responsavel;} public void setResponsavel(Responsavel responsavel){this.responsavel=responsavel;}
}
