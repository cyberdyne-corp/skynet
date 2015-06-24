package skynet.stress

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class HelloSimulation extends Simulation {

val httpProtocol = http
    .baseURL("http://INSERT-ROUTABLE-IP")
    .acceptHeader("application/json, text/plain, */*")
    .acceptEncodingHeader("gzip, deflate")
    .acceptLanguageHeader("en-US,en;q=0.5")
    // .connection("keep-alive")
    .contentTypeHeader("application/json; charset=UTF-8")
    .userAgentHeader("Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:35.0) Gecko/20100101 Firefox/35.0")

  val scn = scenario("HelloSimulation")
    .exec(http("request_1")
    .get("/sleep?max=10"))
    //.pause(5)


  setUp(
    scn.inject(
      nothingFor(4 seconds), // 1
      atOnceUsers(10), // 2
      rampUsers(30) over (10 seconds), // 3
      constantUsersPerSec(5) during (10 seconds), // 4
      constantUsersPerSec(5) during (10 seconds) randomized, // 5
      rampUsersPerSec(10) to 20 during (20 seconds), // 6
      rampUsersPerSec(10) to 20 during (15 seconds) randomized, // 7
      splitUsers(10) into (rampUsers(2) over (15 seconds)) separatedBy (2 seconds), // 8
      splitUsers(10) into (rampUsers(2) over (20 seconds)) separatedBy atOnceUsers(5), // 9
      heavisideUsers(10) over (10 seconds) // 10
    )
  ).protocols(httpProtocol)



}
