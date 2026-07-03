package com.cooperative.transport.enums;

public enum StatutReservationId {
    CONFIRMEE(1L),
    ANNULEE(2L);

    private final Long id;

    StatutReservationId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }
}
