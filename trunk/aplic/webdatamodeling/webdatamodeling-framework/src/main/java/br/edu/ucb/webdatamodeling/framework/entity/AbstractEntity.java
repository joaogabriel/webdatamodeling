package br.edu.ucb.webdatamodeling.framework.entity;

import java.io.Serializable;

public abstract class AbstractEntity<ID extends Serializable> implements Entity<ID> {

	@Override
	public String toString() {
		return super.toString();
	}
	
	@Override
	public boolean equals(Object obj) {
		return super.equals(obj);
	}
	
	@Override
	public int hashCode() {
		return super.hashCode();
	}
	
}
