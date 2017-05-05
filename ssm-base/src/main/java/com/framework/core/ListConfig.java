package com.framework.core;

public class ListConfig {
	
	private GridConfig gridConfig;
	
	public ListConfig(String gridConfig){
		this.gridConfig = new GridConfig(gridConfig);
	}

	public GridConfig getGridConfig() {
		return gridConfig;
	}

	public void setGridConfig(GridConfig gridConfig) {
		this.gridConfig = gridConfig;
	}
	
	

}

class GridConfig{
	//–’√˚:name,ƒÍ¡‰:age,” œ‰:email
	private String gridConfig;
	
	private String nCols[];
	private String pCols[];
	private String colProcFuns[];
	
	public GridConfig(String gridConfig){
		
		this.gridConfig = gridConfig;
		
		initGridConfig();
	}
	
	private void initGridConfig(){
		String item1[] = this.gridConfig.split(",");
		nCols = new String[item1.length];
		pCols = new String[item1.length];
		colProcFuns = new String[item1.length];
		for(int i=0;i<item1.length;i++){
			String item11 = item1[i];
			String item2[] = item11.split(":");
			
			nCols[i] = item2[0];
			pCols[i] = item2[1];
			
			if(item2.length>2){
				colProcFuns[i] = item2[2];
			}else{
				colProcFuns[i] = "gridColProcFun";
			}
			
		}
		 
	}

	public String getGridConfig() {
		return gridConfig;
	}

	public void setGridConfig(String gridConfig) {
		this.gridConfig = gridConfig;
	}

	public String[] getnCols() {
		return nCols;
	}

	public void setnCols(String[] nCols) {
		this.nCols = nCols;
	}

	public String[] getpCols() {
		return pCols;
	}

	public void setpCols(String[] pCols) {
		this.pCols = pCols;
	}

	public String[] getColProcFuns() {
		return colProcFuns;
	}

	public void setColProcFuns(String[] colProcFuns) {
		this.colProcFuns = colProcFuns;
	}
	
	
}
