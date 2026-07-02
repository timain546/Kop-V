package com.cooperative.transport.enums;

public enum StatutPaiementId {
    NON_PAYE(1L),
    PART_PAYE(2L),
    PAYE(3L);

    private final Long id;

    StatutPaiementId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }
}
