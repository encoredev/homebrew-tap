class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221023"
    checksums = {
        "darwin_arm64" => "12da1b6f5869b49a66886123eef3920a1de1875a5ad4d2bdd4e53cc82ca27f12",
        "darwin_amd64" => "653803e0538838c79751c049816ac1e3d66ed33989d892240790dbed5f5bd696",
        "linux_arm64"  => "f40eff2c535461c6392a7e7bfc1eb15f40fade7962521f01e0b0955d47c37b74",
        "linux_amd64"  => "23c10b7b5c559301dfa0ff2e99e4ea3326d543c09a4008d4512bb900922f911e",
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
