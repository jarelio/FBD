
package model.bean;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Jarelio Filho
 */
public class Album {
    private int cod_album;
    private String descricao;
    private float preco_compra;
    private Timestamp data_compra;
    private String tipo_compra;
    private Date data_grav;
    private int cod_grav;

    public Album() {
    }

    public Album(int cod_album, String descricao, float preco_compra, Timestamp data_compra, String tipo_compra, Date data_grav, int cod_grav) {
        this.cod_album = cod_album;
        this.descricao = descricao;
        this.preco_compra = preco_compra;
        this.data_compra = data_compra;
        this.tipo_compra = tipo_compra;
        this.data_grav = data_grav;
        this.cod_grav = cod_grav;
    }
    
    public int getCodAlbum(){
        return cod_album;
    }
    
    public void setCodAlbum(int cod_alb){
         this.cod_album = cod_alb;
    }
    
    public String getDescricao(){
        return descricao;
    }
    
    public void setDescricao(String desc){
        this.descricao = desc;
    }
    
    public float getPrecoCompra(){
        return preco_compra;
    }
    
    public void setPrecoCompra(float preco_comp){
        this.preco_compra = preco_comp;
    }
    
    public Timestamp getDataCompra(){
        return data_compra;
    }
        
    public void setDataCompra(Timestamp data_comp){
        this.data_compra = data_comp;
    }
    
    public String getTipoCompra(){
        return tipo_compra;
    }
    
    public void setTipoCompra(String tipo_comp){
        this.tipo_compra = tipo_comp;
    }
    
    public Date getDataGrav(){
        return data_grav;
    }
    
    public void setDataGrav(Date data_grav){
        this.data_grav = data_grav;
    }
    
   public int getCodGrav(){
       return cod_grav;
   }
   
   public void setCodGrav(int cod_grav){
       this.cod_grav = cod_grav;
   }

    
}
