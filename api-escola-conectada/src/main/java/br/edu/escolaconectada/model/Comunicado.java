package br.edu.escolaconectada.model;
import jakarta.persistence.*; import java.time.LocalDateTime;
@Entity
public class Comunicado {
 @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
 private String titulo; @Column(length=2000) private String mensagem; private LocalDateTime dataEnvio = LocalDateTime.now();
 @ManyToOne private Professor professor; @ManyToOne private Aluno aluno;
 public Long getId(){return id;} public void setId(Long id){this.id=id;}
 public String getTitulo(){return titulo;} public void setTitulo(String titulo){this.titulo=titulo;}
 public String getMensagem(){return mensagem;} public void setMensagem(String mensagem){this.mensagem=mensagem;}
 public LocalDateTime getDataEnvio(){return dataEnvio;} public void setDataEnvio(LocalDateTime dataEnvio){this.dataEnvio=dataEnvio;}
 public Professor getProfessor(){return professor;} public void setProfessor(Professor professor){this.professor=professor;}
 public Aluno getAluno(){return aluno;} public void setAluno(Aluno aluno){this.aluno=aluno;}
}
