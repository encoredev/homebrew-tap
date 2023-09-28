class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230928"
    checksums = {
        "darwin_arm64" => "cd38036f8721b1b8e6c5e8a87420b47539d2db6c6e0d258906a9c693924c79f2",
        "darwin_amd64" => "4881a2596e9cd4cfc0e0ef833b6490b9709bd1bf234841188d6ec076ae198d92",
        "linux_arm64"  => "9aa665549803f565a3e32572f5e583f56b6c776d9aacb2220c39650734699b45",
        "linux_amd64"  => "83b915f0b8c62767495039102926d3b12415387e1b10a46f1426dea0f24939d7",
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
