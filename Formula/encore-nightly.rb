class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231002"
    checksums = {
        "darwin_arm64" => "8c863bf7127e307532e320d2029d9779a0487e79967fb9a1382282191c7f3e93",
        "darwin_amd64" => "f2b5840624fabf7261b2419d25fedfc5842c616faff43f6bb19d2d1b3886a873",
        "linux_arm64"  => "d992c360bd212258ec88f518c40d608c9958e299d26667bf3ca95f0cb9e0e274",
        "linux_amd64"  => "73465d2e3eda883aea2fb3185d11cf078235fc648be4c234b9417386419053c8",
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
