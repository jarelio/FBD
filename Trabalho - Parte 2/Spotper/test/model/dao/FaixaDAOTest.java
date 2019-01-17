/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Time;
import model.bean.Faixa;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Jarelio Filho
 */
public class FaixaDAOTest {
    
    public FaixaDAOTest() {
    }

    @Test
    public void inserir() {
        Time tempo;
        String stringTempo = "00:05:00";
        tempo = Time.valueOf(stringTempo);
        Faixa faixa = new Faixa(1,2,"DDD","Primeira Faixa Album 2 Inserida no Banco",tempo,1);
        FaixaDAO faixadao = new FaixaDAO();
        
        if(faixadao.inserir(faixa)){
            System.out.println("Faixa inserida com sucesso!");
        }else{
            fail("Erro ao inserir Faixa!");
        }
    }
    
}
