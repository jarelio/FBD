
package model.dao;

import java.sql.Connection;
import connection.ConnectionFactory;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.bean.Faixa;

/**
 *
 * @author Jarelio Filho
 */
public class FaixaDAO {
    
    private Connection con = null;

    public FaixaDAO() {
        con = ConnectionFactory.conectar();
    }
    
    public boolean inserir(Faixa faixa){
        
        String sql = "INSERT INTO faixa (numero_faixa,cod_album,tipo_grav,descricao,tempo_exec_faixa,id_tipo_comp) VALUES (?,?,?,?,?,?)";
        
        PreparedStatement stmt = null;
        
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,faixa.getNumFaixa());
            stmt.setInt(2,faixa.getCodAlbum());
            stmt.setString(3,faixa.getTipoGrav());
            stmt.setString(4,faixa.getDescricao());
            stmt.setTime(5,faixa.getTempoExec());
            stmt.setInt(6,faixa.getIdTipoComp());
            stmt.executeUpdate();       
            return true;
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
            return false;
        }finally{
            ConnectionFactory.desconectar(con, stmt);
        }
        
    } 

    public List<Faixa> selectFaixasPlaylist(int cod_play){
        
        List<Faixa> faixas = new ArrayList<>();
        
        String sql = "select f.descricao,f.cod_album,f.tempo_exec_faixa from faixa f,faixa_playlist fp where fp.numero_faixa=f.numero_faixa and fp.cod_album = f.cod_album and fp.cod_play=?";
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, cod_play);
            rs = stmt.executeQuery();
            while(rs.next()){
                Faixa faixa = new Faixa();
                faixa.setDescricao(rs.getString(1));
                faixa.setCodAlbum(rs.getInt(2));
                faixa.setTempoExec(rs.getTime(3));
                faixas.add(faixa);
            }
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
        }finally{
            ConnectionFactory.desconectar(con, stmt, rs);
        }
        
        return faixas;
    }
    
    public boolean delete(int numero_faixa, int cod_album, int cod_play){
        
        String sql = "DELETE FROM faixa_playlist WHERE numero_faixa=? and cod_play=? and cod_album=?";
        String sql3 = "update playlist set duracao_exec = (CAST(duracao_exec as datetime) - \n" +
                      "(select CAST(f.tempo_exec_faixa as datetime) from faixa f where f.numero_faixa=? and f.cod_album=?))\n" +
                      "where cod_play=?";
        PreparedStatement stmt = null;
        
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, numero_faixa);
            stmt.setInt(2, cod_play);
            stmt.setInt(3, cod_album);
            stmt.executeUpdate();
            
            stmt = con.prepareStatement(sql3);
            stmt.setInt(1, numero_faixa);
            stmt.setInt(2, cod_album);
            stmt.setInt(3, cod_play);
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
            return false;
        }finally{
            ConnectionFactory.desconectar(con, stmt);
        }
        
    }
    
    public Faixa selectFaixaDescricao(String descricao){       
        String sql = "select f.numero_faixa,f.cod_album from faixa f where f.descricao=?";
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Faixa faixa = new Faixa();
        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, descricao);
            rs = stmt.executeQuery();
            while(rs.next()){
                faixa.setNumFaixa(rs.getInt(1));
                faixa.setCodAlbum(rs.getInt(2));
            }
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
        }finally{
            ConnectionFactory.desconectar(con, stmt, rs);
        }
        
        return faixa;        
    }
    public List<Faixa> selectFaixasAlbum(int cod_album){
        
        List<Faixa> faixas = new ArrayList<>();
        
        String sql = "select f.numero_faixa,f.descricao,f.tempo_exec_faixa from faixa f where f.cod_album=?";
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, cod_album);
            rs = stmt.executeQuery();
            while(rs.next()){
                Faixa faixa = new Faixa();
                faixa.setNumFaixa(rs.getInt(1));
                faixa.setDescricao(rs.getString(2));
                faixa.setTempoExec(rs.getTime(3));
                faixas.add(faixa);
            }
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
        }finally{
            ConnectionFactory.desconectar(con, stmt, rs);
        }
        
        return faixas;
    }
    public boolean inserirPlaylist(int numero_faixa, int cod_play, int cod_album){
        
        String sql = "SELECT * FROM faixa f WHERE f.numero_faixa=? and f.cod_album=? ";
        String sql2 = "INSERT INTO faixa_playlist VALUES (?,?,?,?,?)";
        String sql3 = "update playlist set duracao_exec = (select cast(sum(cast(cast(tempo_exec_faixa as datetime) as float)) as datetime)\n" +
                                                           "from faixa f, faixa_playlist fp \n" +
                                                           "where f.numero_faixa=fp.numero_faixa and f.cod_album=fp.cod_album and fp.cod_play=?) where cod_play=?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,numero_faixa);
            stmt.setInt(2, cod_album);
            rs = stmt.executeQuery();

            while(rs.next()){
                stmt = con.prepareStatement(sql2);
                stmt.setInt(1,cod_play);
                stmt.setInt(2,rs.getInt(1));
                stmt.setInt(3,rs.getInt(2));
                stmt.setInt(4,0);
                stmt.setString(5,"10/10/10");
                stmt.executeUpdate();
            }
            stmt = con.prepareStatement(sql3);
            stmt.setInt(1, cod_play);
            stmt.setInt(2, cod_play);
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
            return false;
        }finally{
            ConnectionFactory.desconectar(con, stmt, rs);
        }
        
    }
}
