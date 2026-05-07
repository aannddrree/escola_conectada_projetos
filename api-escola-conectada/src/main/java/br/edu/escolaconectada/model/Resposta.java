package br.edu.escolaconectada.model;
import jakarta.persistence.*; import java.time.LocalDateTime;
@Entity
public class Resposta {
 @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
 @Column(length=2000) private String mensagemResposta; private LocalDateTime dataResposta = LocalDateTime.now();
 @ManyToOne private Comunicado comunicado; @ManyToOne private Responsavel responsavel;
 public Long getId(){return id;} public void setId(Long id){this.id=id;}
 public String getMensagemResposta(){return mensagemResposta;} public void setMensagemResposta(String mensagemResposta){this.mensagemResposta=mensagemResposta;}
 public LocalDateTime getDataResposta(){return dataResposta;} public void setDataResposta(LocalDateTime dataResposta){this.dataResposta=dataResposta;}
 public Comunicado getComunicado(){return comunicado;} public void setComunicado(Comunicado comunicado){this.comunicado=comunicado;}
 public Responsavel getResponsavel(){return responsavel;} public void setResponsavel(Responsavel responsavel){this.responsavel=responsavel;}
}
