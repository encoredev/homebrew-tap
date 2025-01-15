class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.45.7"
    checksums = {
        "darwin_arm64" => "7d4cf590306c6c7628215474ff8adbc573d4c6a97256ee1afa6ccea39469116c",
        "darwin_amd64" => "f4da2a0e6cf5547e23fbc19483e6623ec6812fdb4acce9360a6d393e2ae5986e",
        "linux_arm64"  => "b5f2a13671aae3cd79f261690fd275e609bb449723d844b5dfef4e81feba0a3b",
        "linux_amd64"  => "7d3a34e45d48131387ced97ff6a547a34db1f269ee2a0d547ba99fab7bd8779e",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
