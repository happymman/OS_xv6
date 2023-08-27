package wellDressedMan.weather2clothes.domain;

import lombok.Data;

@Data
public class Member{
    private Long mbrIdx;
    private String mbrId;
    private String mbrPassword;

    public Member(){};

    public Member(Long mbrIdx, String mbrId, String mbrPassword) {
        this.mbrIdx = mbrIdx;
        this.mbrId = mbrId;
        this.mbrPassword = mbrPassword;
    }
}
