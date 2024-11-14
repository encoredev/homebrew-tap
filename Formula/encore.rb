class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.10"
    checksums = {
        "darwin_arm64" => "f47384d489dd78d42079d2ed5f367510215c81294ab38abdf2d1afeb07f0eca6",
        "darwin_amd64" => "d21300d67668e1b6879c93ad285f673429dfc4692f5487dade7e552c7f4c1598",
        "linux_arm64"  => "9a58a5a0a71847ae2cb99ff1474c3277a611a433a721b8461a014e87e0459132",
        "linux_amd64"  => "e35b4fdfe610dcab8c4d01a3334a86df6ed5bcdefd40bc2b8dce6752f8366758",
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
