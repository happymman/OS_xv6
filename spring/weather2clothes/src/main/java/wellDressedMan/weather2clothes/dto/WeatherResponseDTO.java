package wellDressedMan.weather2clothes.dto;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class WeatherResponseDTO {
    private WeatherResponse weatherResponse;
    private String message;
}
