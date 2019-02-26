class Neo4j232 < Formula
  desc "Robust (fully ACID) transactional property graph database"
  homepage "http://neo4j.com"
  url "http://dist.neo4j.org/neo4j-community-2.3.2-unix.tar.gz"
  version "2.3.2"
  sha256 "37e24d95c914c54d5cbbe99473d4beef89da78adb2db04eb87258a489225932a"

  bottle :unneeded

  depends_on :java => "1.7+"

  def install
    # Remove windows files
    rm_f Dir["bin/*.bat"]

    # Install jars in libexec to avoid conflicts
    libexec.install Dir["*"]

    # Symlink binaries
    #bin.install_symlink Dir["#{libexec}/bin/neo4j-{,-shell,-import}"]
    bin.install_symlink "#{libexec}/bin/neo4j" => "neo4j-232"
    bin.install_symlink "#{libexec}/bin/neo4j-shell" => "neo4j-232-shell"
    bin.install_symlink "#{libexec}/bin/neo4j-import" => "neo4j-232-import"

    # Adjust UDC props
    # Suppress the empty, focus-stealing java gui.
    (libexec/"conf/neo4j-wrapper.conf").append_lines <<-EOS.undent
      wrapper.java.additional=-Djava.awt.headless=true
      wrapper.java.additional.4=-Dneo4j.ext.udc.source=homebrew
    EOS
  end

  test do
    ENV.java_cache
    ENV["NEO4J_LOG"] = testpath/"libexec/data/log/neo4j.log"
    ENV["NEO4J_PIDFILE"] = testpath/"libexec/data/neo4j-service.pid"
    mkpath testpath/"libexec/data/log"
    assert_match /Neo4j .*is not running/i, shell_output("#{bin}/neo4j status", 3)
  end
end
