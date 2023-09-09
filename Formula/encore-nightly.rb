class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230909"
    checksums = {
        "darwin_arm64" => "39386634da60b783e6344c54250a6df1c26b61f43bc76a8c286bb2ef7e2997f5",
        "darwin_amd64" => "b1c1f7dc157775435a4930eb103e465dc23815f255737694ea766885fcdf9e96",
        "linux_arm64"  => "03d18a8be845ca14593513aa709244e263641692607547d245c1360d41691c68",
        "linux_amd64"  => "01180c5b9c9d75a8275b226cb5dcb8c4ca05f5e8c0540456b3ea3fff5af73045",
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
