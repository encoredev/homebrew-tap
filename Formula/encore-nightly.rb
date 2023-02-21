class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230221"
    checksums = {
        "darwin_arm64" => "5726b2272c1dda707be16977568e729820359d89a3ef956476e86ee6e2066a04",
        "darwin_amd64" => "49776541c5290010c46bd1f2afc7628cc748367e5055b3ab97c11bd9bd4a9b15",
        "linux_arm64"  => "c791ed84ffb30da0f320a5333c8af29e110146b932866afda2b9bf3759de30ab",
        "linux_amd64"  => "bef741a967dea02db3dd2496802fa9d7f25ebb3a255976089fc4dea8f3e0f9ff",
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
