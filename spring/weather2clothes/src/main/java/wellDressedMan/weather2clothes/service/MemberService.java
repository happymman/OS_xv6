package wellDressedMan.weather2clothes.service;

import wellDressedMan.weather2clothes.domain.Member;
import java.util.Optional;

public interface MemberService {
    Member createMember(Member member);
    Optional<Member> findByMbrId(String mbrId);

}
