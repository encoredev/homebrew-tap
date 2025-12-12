class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.53.0"
    checksums = {
        "darwin_arm64" => "2044121043f43ae764083e1d89df585590574607efbde7fbbdc0f7c45b138f0a",
        "darwin_amd64" => "8bc76247ff2ac1e1a4c07dc9834ae6afffa84db77907cdcd988718e891e7a12e",
        "linux_arm64"  => "d67692643121c3e8e48cb7ef75faf5b2feaeb76883a0da6a6dbc976d465706a1",
        "linux_amd64"  => "c2e9163082dd6c41ac0385cbbf9d59def613e6ed6e90da7f21dc108b22e779ca",
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
