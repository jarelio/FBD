/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Jarelio Filho
 */
public class AlbumDAOTest {
    
    public AlbumDAOTest() {
    }

    @Test
    public void inserirPlaylist() {
        
        AlbumDAO albumdao = new AlbumDAO();
        
        if(albumdao.inserirPlaylist(1,1)){
            System.out.println("Album adicionado na playlist com sucesso!");
        }else{
            fail("Erro ao inserir faixas na playlist!");
        }
    }
    
}
