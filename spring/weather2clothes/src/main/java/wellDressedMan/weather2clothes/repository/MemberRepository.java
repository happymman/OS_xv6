package wellDressedMan.weather2clothes.repository;

import wellDressedMan.weather2clothes.domain.Member;
import java.util.Optional;

public interface MemberRepository {

    Member createMember(Member member);
    Optional<Member> findByMbrId(String mbrId);
}
