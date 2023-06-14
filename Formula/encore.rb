class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.20.4"
    checksums = {
        "darwin_arm64" => "4aca0ecbdd8f1be74c0661cb7fb6563dd0475914fd042de44dbcdb35986cfb8a",
        "darwin_amd64" => "6000822acc9a7ba7702ea5a20303bb3bd9cd14e34e01adaeca6dea6b879193e6",
        "linux_arm64"  => "7d7d958940bb4b65928b92444bef20c2cd726d733f932024c929eb76ff2b6301",
        "linux_amd64"  => "a90a426923e70f16ffcf0fc36987eb7df21001ad48227c3d96e1c936b678d84c",
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
