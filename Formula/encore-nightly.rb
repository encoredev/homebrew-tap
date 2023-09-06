class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230906"
    checksums = {
        "darwin_arm64" => "eaf8448ce25591d0eaa93d16534a47ad4b8525fc570b02b3e14737bf46b19c75",
        "darwin_amd64" => "7fe08be1397414538ddfbd0e109f4138c45517119813db7f2ecaa3f4502e16cf",
        "linux_arm64"  => "ca1676d314ec785323872e2cf922cbc511f91850f9b9f94a6d9126b489e8533a",
        "linux_amd64"  => "156745fef98994919dfe01e75d6ecef81614a3e58f51e6cfa01acf565f32db07",
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
