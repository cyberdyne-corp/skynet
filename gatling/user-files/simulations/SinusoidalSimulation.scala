package skynet.stress

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class SinusoidalSimulation extends Simulation {

val httpProtocol = http
    .baseURL("http://INSERT-ROUTABLE-IP")
    .acceptHeader("application/json, text/plain, */*")
    .acceptEncodingHeader("gzip, deflate")
    .acceptLanguageHeader("en-US,en;q=0.5")
    .contentTypeHeader("application/json; charset=UTF-8")
    .userAgentHeader("Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:35.0) Gecko/20100101 Firefox/35.0")

  val scn = scenario("SinusoidalScenario")
    .exec(http("sleep_static_5sec")
    .get("/sleep?duration=5"))

  setUp(
    scn.inject(
      rampUsers(100) over (15 seconds),
      rampUsers(25) over (30 seconds),
      rampUsers(100) over (15 seconds),
      rampUsers(25) over (15 seconds),
      rampUsers(100) over (15 seconds),
      rampUsers(25) over (30 seconds),
      rampUsers(100) over (15 seconds),
      rampUsers(25) over (15 seconds),
      rampUsers(100) over (15 seconds),
      rampUsers(25) over (30 seconds),
      rampUsers(100) over (15 seconds),
      rampUsers(25) over (15 seconds),
      rampUsers(100) over (15 seconds),
      rampUsers(25) over (30 seconds),
      rampUsers(100) over (15 seconds),
      rampUsers(25) over (15 seconds)
    )
  ).protocols(httpProtocol)
}
